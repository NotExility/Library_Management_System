import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { Book } from '../books/entities/book.entity';
import { Member } from '../members/entities/member.entity';
import { Borrowing } from '../borrowings/entities/borrowing.entity';

@Injectable()
export class DashboardService {

  constructor(
    @InjectRepository(Book)
    private bookRepository: Repository<Book>,

    @InjectRepository(Member)
    private memberRepository: Repository<Member>,

    @InjectRepository(Borrowing)
    private borrowingRepository: Repository<Borrowing>,
  ) {}

  async getStats() {

    const books =
      await this.bookRepository.count();

    const members =
      await this.memberRepository.count();

    const borrowings =
      await this.borrowingRepository.count();

    return {
      books,
      members,
      borrowings,
    };
  }
}