import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { Borrowing } from './entities/borrowing.entity';
import { CreateBorrowingDto } from './dto/create-borrowing.dto';

@Injectable()
export class BorrowingsService {

  constructor(
    @InjectRepository(Borrowing)
    private readonly borrowingRepository:
      Repository<Borrowing>,
  ) {}

  create(dto: CreateBorrowingDto) {
    return this.borrowingRepository.save(dto);
  }

  findAll() {
    return this.borrowingRepository.find();
  }

  async remove(id: number) {
    await this.borrowingRepository.delete(id);

    return {
      message: 'Borrowing deleted',
    };
  }
}