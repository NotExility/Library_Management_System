import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

import { Repository } from 'typeorm';

import { Member } from './entities/member.entity';
import { CreateMemberDto } from './dto/create-member.dto';

@Injectable()
export class MembersService {

  constructor(
    @InjectRepository(Member)
    private readonly memberRepository: Repository<Member>,
  ) {}

  create(createMemberDto: CreateMemberDto) {
    return this.memberRepository.save(
      createMemberDto,
    );
  }

  findAll() {
    return this.memberRepository.find();
  }

  findOne(id: number) {
    return this.memberRepository.findOne({
      where: { id },
    });
  }

  async remove(id: number) {
    await this.memberRepository.delete(id);

    return {
      message: 'Member deleted',
    };
  }
}